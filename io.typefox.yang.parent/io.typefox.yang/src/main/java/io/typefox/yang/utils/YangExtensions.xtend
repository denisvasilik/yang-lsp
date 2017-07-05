package io.typefox.yang.utils

import com.google.inject.Singleton
import io.typefox.yang.yang.AbstractModule
import io.typefox.yang.yang.Range
import io.typefox.yang.yang.Statement
import io.typefox.yang.yang.Type
import io.typefox.yang.yang.Typedef
import io.typefox.yang.yang.YangVersion
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.EcoreUtil2

import static extension org.eclipse.xtext.EcoreUtil2.getContainerOfType

/**
 * Convenient extension methods for the YANG language.
 * 
 * @author akos.kitta 
 */
@Singleton
class YangExtensions {

	/**
	 * The {@code 1.0} YANG version.
	 */
	public static val YANG_1 = "1";

	/**
	 * The {@code 1.1} YANG version.
	 */
	public static val YANG_1_1 = "1.1";

	/**
	 * Returns with the YANG version of the module where the AST node element is contained.
	 * <p>
	 * Returns with version {@code 1} if the container module does not declare the version or the version equals
	 * with {@code 1}.
	 * <p>
	 * Returns with {@code 1.1} if the container module has declared YANG version, and that equals to {@code 1.1},
	 * otherwise returns with {@code null}. Also returns with {@code null}, if the argument is not contained in a module.
	 */
	def getYangVersion(EObject it) {
		val module = getContainerOfType(AbstractModule);
		if (module === null) {
			return null;
		}
		val version = module.firstSubstatementsOfType(YangVersion)?.yangVersion;
		if (null === version || YANG_1 == version) {
			return YANG_1;
		}
		return if(YANG_1_1 == version) YANG_1_1 else null;
	}

	/**
	 * Returns with all sub-statements of a given type for the statement argument.
	 */
	def <S extends Statement> substatementsOfType(Statement it, Class<S> clazz) {
		return substatements.filter(clazz);
	}
	
	/**
	 * Returns with the first sub-statement of a given type for the statement argument or {@code null}.
	 */
	def <S extends Statement> firstSubstatementsOfType(Statement it, Class<S> clazz) {
		return substatementsOfType(clazz).head;
	}
	
	/**
	 * Returns with the {@code type of t}
	 */
	def Type getType(Typedef it) {
		return substatementsOfType(Type).head;
	}
	
	/**
	 * Returns with the container type of the range argument.
	 */
	def Type getType(Range it) {
		return EcoreUtil2.getContainerOfType(it, Type);
	}

}